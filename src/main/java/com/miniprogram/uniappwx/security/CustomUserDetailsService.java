package com.miniprogram.uniappwx.security;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.miniprogram.uniappwx.entity.User;
import com.miniprogram.uniappwx.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

	private final UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
		wrapper.eq(User::getUsername, username);
		User user = userMapper.selectOne(wrapper);

		if (user == null) {
			throw new UsernameNotFoundException("用户不存在: " + username);
		}

		return new CustomUserDetails(user);
	}
}
